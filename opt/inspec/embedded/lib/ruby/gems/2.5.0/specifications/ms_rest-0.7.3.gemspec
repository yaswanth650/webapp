# -*- encoding: utf-8 -*-
# stub: ms_rest 0.7.3 ruby lib

Gem::Specification.new do |s|
  s.name = "ms_rest".freeze
  s.version = "0.7.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/Azure/azure-sdk-for-ruby/issues", "changelog_uri" => "https://github.com/Azure/azure-sdk-for-ruby/blob/master/runtime/ms_rest/CHANGELOG.md", "documentation_uri" => "https://azure.microsoft.com/en-us/develop/ruby/", "homepage_uri" => "https://aka.ms/azure-sdk-for-ruby", "source_code_uri" => "https://github.com/Azure/azure-sdk-for-ruby/tree/ms_rest-v0.7.3" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Microsoft Corporation".freeze]
  s.date = "2018-09-25"
  s.description = "Azure Client Library for Ruby.".freeze
  s.email = "azsdkteam@microsoft.com".freeze
  s.homepage = "https://aka.ms/ms_rest".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Azure Client Library for Ruby.".freeze

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.9"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.3"])
      s.add_runtime_dependency(%q<timeliness>.freeze, ["~> 0.3"])
      s.add_runtime_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<faraday>.freeze, ["~> 0.9"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.9"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.3"])
      s.add_dependency(%q<timeliness>.freeze, ["~> 0.3"])
      s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0"])
      s.add_dependency(%q<faraday>.freeze, ["~> 0.9"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.9"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.3"])
    s.add_dependency(%q<timeliness>.freeze, ["~> 0.3"])
    s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0"])
    s.add_dependency(%q<faraday>.freeze, ["~> 0.9"])
  end
end
