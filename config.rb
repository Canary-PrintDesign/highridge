# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

configure :development do
  activate :livereload
end

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

activate :external_pipeline,
  name: :webpack,
  command: build? ? 'yarn run build': 'yarn start',
  source: '.tmp/dist',
  latency: 1

activate :directory_indexes
activate :aria_current

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'images'

require 'susy'

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'highridge.canaryprint.ca'
  s3_sync.region                     = 'us-west-2'
  s3_sync.aws_access_key_id          = 'REDACTED: Use .s3_sync file with info in it'
  s3_sync.aws_secret_access_key      = 'REDACTED: Use .s3_sync file with info in it'
  s3_sync.delete                     = true
  s3_sync.prefer_gzip                = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.prefix                     = ''
  s3_sync.version_bucket             = false
end

require 'mime-types'
