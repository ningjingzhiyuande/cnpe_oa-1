# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone
date_formats = {
  concise: '%Y/%m/%d' # 13-Jan-2014
}

Time::DATE_FORMATS.merge! date_formats
Date::DATE_FORMATS.merge! date_formats
