FROM python:3

# Install pandoc
ARG PANDOC_URL=https://github.com/jgm/pandoc/releases/download/1.19.2.1/pandoc-1.19.2.1-1-amd64.deb
RUN \
  curl -L -o /tmp/pandoc.deb $PANDOC_URL \
  && dpkg -i /tmp/pandoc.deb \
  && rm /tmp/pandoc.deb

WORKDIR /usr/src/app

COPY requirements ./requirements
COPY requirements.txt ./

# Install pip packages
ARG REQUIREMENTS_FILE=requirements.txt
RUN pip install --no-cache-dir -r $REQUIREMENTS_FILE

COPY . .

# Generate django compressor static files
RUN python manage.py compress

# Generate latex static files
ARG REMOVE_TEXLIVE=true
RUN apt-get update \
  && apt-get install -y \
    pdf2svg \
    texlive \
    texlive-latex-extra \
    texlive-fonts-extra \
  && python manage.py loadarticles \
  && if $REMOVE_TEXLIVE; then \
    apt-get purge --auto-remove -y \
      pdf2svg \
      texlive \
      texlive-latex-extra \
      texlive-fonts-extra \
  ;fi \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Heroku requires that we use a non-root user
RUN useradd -m localuser
USER localuser

CMD ["/usr/src/app/entrypoint.sh"]
