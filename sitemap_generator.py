# based on https://www.jcchouinard.com/create-xml-sitemap-with-python/

import pandas as pd
import os
import re
import datetime
from jinja2 import Template
from xml.sax.saxutils import escape
from pathlib import Path
# import gzip

# setting the base url
base_url = os.environ['TERMGIT_CANONICAL'] + "/"

# input directory
input_dir = './output'

# output directory
output_dir = './input/sitemap/'

# make sure output directory exists
Path(output_dir).mkdir(parents=True, exist_ok=True)

# retrieve all HTML files in the output directory
html_files = [escape(f) for f in os.listdir('./output') if f.endswith('.html')]

# list of regex used to remove elements from html_files:
# - remove versioned files (starting e.g. with "20220202-083434-*")
# - remove all "*.change.history.html" files
# - remove all "*.download.html" files
# - remove all "*.previous-versions.html" files
# - remove all quality assurance files (starting with "qa")
# - remove searchforms (starting with "search")
filter_regex_list = ['^\d{8}-\d{6}-.+', '.+\.change\.history\.html$', '.+\.download\.html$', '.+\.previous-versions\.html$', '^qa.+', '^search.+']

# remove files which match given regex
for regex in filter_regex_list:
  html_files = list(filter(lambda html_file_name: not re.match(regex, html_file_name), html_files))

# proceed only if there are any HTML files
if len(html_files) > 0:
  # set up maximum number of URLs (recommended max 50000)
  n = 50000

  # control if sitemapindex is created or not
  create_sitemapindex = False
  if len(html_files) > n:
    create_sitemapindex = True

  html_files_df = pd.DataFrame(html_files)

  # get today's date to add as lastmod
  lastmod_date = datetime.datetime.now().strftime('%Y-%m-%d')

  # create new empty column to store the splitted file number
  html_files_df.loc[:, 'name'] = ''
  # add column containing site's base URL
  html_files_df.loc[:, 'baseurl'] = base_url
  # add lastmod date
  html_files_df.loc[:, 'lastmod'] = lastmod_date
  # add changefreq
  html_files_df.loc[:, 'changefreq'] = 'weekly'
  # add priority
  html_files_df.loc[:, 'priority'] = '1.0'

  # for old versions set changefreq and priority differently
  html_files_df.loc[html_files_df.loc[:,0].str.contains(r'^\d{8}-\d{6}-.+'), 'changefreq'] = 'never'
  html_files_df.loc[html_files_df.loc[:,0].str.contains(r'^\d{8}-\d{6}-.+'), 'priority'] = '0.5'

  # create a sitemap template to populate
  urlset_template_text='''<?xml version="1.0" encoding="UTF-8"?>
  <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
      {% for page in pages %}
      <url>
          <loc>{{page[3]|safe}}{{page[1]|safe}}</loc>
          <lastmod>{{page[4]}}</lastmod>
          <changefreq>{{page[5]}}</changefreq>
          <priority>{{page[6]}}</priority>
      </url>
      {% endfor %}
  </urlset>'''

  urlset_template = Template(urlset_template_text)

  # sitemap_filename_for_robot_txt = 'sitemap.xml.gz'
  sitemap_filename_for_robot_txt = 'sitemap.xml'

  if create_sitemapindex:
    # split the files with the maximum number of rows specified
    splitted_df = [pd.DataFrame(html_files_df[i:i+n]) for i in range(0,html_files_df.shape[0],n)]

    # for each file created, add a file number to a new column of the dataframe
    for i,v in enumerate(splitted_df):
      v.loc[:,'name'] = str(v.iloc[0,1])+'_'+str(i)


    urlset_filename_list = []
    # fill the sitemap template and write file
    for i in splitted_df:
        # Render each row / column in the sitemap
        urlset_output = urlset_template.render(pages = i.itertuples())

        # create a filename for each sitemap like: sitemap_0.xml, sitemap_1.xml, etc.
        urlset_filename = 'sitemap' + str(i.iloc[0,1]) + '.xml'

        # # create a filename for each sitemap like: sitemap_0.xml.gz, sitemap_1.xml.gz, etc.
        # urlset_filename = 'sitemap' + str(i.iloc[0,1]) + '.xml.gz'

        # append the filename to the list of filenames for sitemap index file
        urlset_filename_list.append(urlset_filename)

        # Write the File to Your Working Folder
        with open(output_dir + urlset_filename, 'wt') as f:
        # with gzip.open(output_dir + urlset_filename, 'wt') as f:
            f.write(urlset_output)

    # create a sitemap index template to populate
    sitemapindex_template_text='''<?xml version="1.0" encoding="UTF-8"?>
    <sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
        {% for page in pages %}
        <sitemap>
            <loc>{{page[2]|safe}}{{page[1]|safe}}</loc>
            <lastmod>{{page[3]}}</lastmod>
        </sitemap>
        {% endfor %}
    </sitemapindex>'''

    sitemapindex_template = Template(sitemapindex_template_text)

    filenames_df = pd.DataFrame(urlset_filename_list)
    # add base URL
    filenames_df.loc[:,'baseurl'] = base_url
    # add last modification date
    filenames_df.loc[:,'lastmod'] = lastmod_date

    # Render each row / column in the sitemap
    sitemapindex_output = sitemapindex_template.render(pages = filenames_df.itertuples())

    # set name for sitemap file for robot.txt
    sitemap_filename_for_robot_txt = 'sitemap_index.xml'

    # write sitemap index
    with open(output_dir + sitemap_filename_for_robot_txt, 'wt') as f:
      f.write(sitemapindex_output)
  else:
    # Render each row / column in the sitemap
    urlset_output = urlset_template.render(pages = html_files_df.itertuples())

    # Write the File to Your Working Folder
    with open(output_dir + sitemap_filename_for_robot_txt, 'wt') as f:
    # with gzip.open(output_dir + sitemap_filename_for_robot_txt, 'wt') as f:
        f.write(urlset_output)

  robot_txt = '''User-agent: *
Disallow: /*.previous-versions.html
Disallow: /*.download.html
Disallow: /*.change.history.html
Allow: /CodeSystem-*
Allow: /ValueSet-*
Allow: /faq_*.html
Allow: /documentation_and_support_*.html
Allow: /index_en.html
Allow: /index.html
Disallow: /

Sitemap: '''
  robot_txt = robot_txt + base_url + sitemap_filename_for_robot_txt
  with open(output_dir + 'robots.txt', 'wt') as f:
    f.write(robot_txt)
else:
  print("WARNING: no HTML files found")