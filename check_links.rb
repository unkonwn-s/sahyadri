# FILE: check_links.rb — CI helper.
# PURPOSE: Runs html-proofer against the built _site output, explicitly
# loading .htmlproofer.yml (the CLI's plain `htmlproofer ./_site` does NOT
# auto-discover this file, despite the filename matching that convention --
# confirmed by CI actually running Images checks and hitting external URLs
# even though the config disables both). This script loads the YAML by
# hand, converts its string-encoded regex patterns (e.g. "/^#/") into real
# Ruby Regexp objects, and passes everything to HTMLProofer explicitly.
require "html-proofer"
require "yaml"

config = YAML.load_file(File.join(__dir__, ".htmlproofer.yml"))

# Converts a "/pattern/" string (as written in the YAML file) into a real
# Regexp. Leaves already-plain strings alone, just in case.
def to_regexp(str)
  if str.start_with?("/") && str.end_with?("/") && str.length > 1
    Regexp.new(str[1..-2])
  else
    str
  end
end

options = {
  disable_external: config["disable_external"],
  allow_hash_href: config["allow_hash_href"],
  ignore_urls: (config["ignore_urls"] || []).map { |u| to_regexp(u) },
  ignore_files: (config["ignore_files"] || []).map { |f| to_regexp(f) },
  checks: config["checks"] || ["Links"],
}

HTMLProofer.check_directory("./_site", options).run
