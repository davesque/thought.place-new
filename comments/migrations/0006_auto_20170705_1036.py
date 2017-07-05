# -*- coding: utf-8 -*-
# Generated by Django 1.11.2 on 2017-07-05 16:36
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('comments', '0005_auto_20170625_1746'),
    ]

    operations = [
        migrations.AlterField(
            model_name='comment',
            name='comment',
            field=models.TextField(help_text='Comment here.  Math supported via KaTeX.  Use "$$", "\\(", or "\\[" delimiters.  To reply to someone, refer to them by name or to their comment by number e.g. "Jane #4", "comment #11", etc.'),
        ),
    ]
