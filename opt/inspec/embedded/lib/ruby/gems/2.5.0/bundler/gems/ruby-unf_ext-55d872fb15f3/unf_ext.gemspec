# -*- encoding: utf-8 -*-
# stub: unf_ext 0.0.7.6 ruby lib
# stub: ext/unf_ext/extconf.rb

Gem::Specification.new do |s|
  s.name = "unf_ext".freeze
  s.version = "0.0.7.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Takeru Ohta".freeze, "Akinori MUSHA".freeze]
  s.date = "2019-04-15"
  s.description = "Unicode Normalization Form support library for CRuby".freeze
  s.email = ["knu@idaemons.org".freeze]
  s.extensions = ["ext/unf_ext/extconf.rb".freeze]
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.files = [".document".freeze, ".gitignore".freeze, ".travis.yml".freeze, "CHANGELOG.md".freeze, "Gemfile".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "ext/unf_ext/extconf.rb".freeze, "ext/unf_ext/unf.cc".freeze, "ext/unf_ext/unf/normalizer.hh".freeze, "ext/unf_ext/unf/table.hh".freeze, "ext/unf_ext/unf/trie/char_stream.hh".freeze, "ext/unf_ext/unf/trie/node.hh".freeze, "ext/unf_ext/unf/trie/searcher.hh".freeze, "ext/unf_ext/unf/util.hh".freeze, "lib/unf_ext.rb".freeze, "lib/unf_ext/version.rb".freeze, "test/helper.rb".freeze, "test/normalization-test.txt".freeze, "test/test_unf_ext.rb".freeze, "unf_ext.gemspec".freeze]
  s.homepage = "https://github.com/knu/ruby-unf_ext".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14".freeze
  s.summary = "Unicode Normalization Form support library for CRuby".freeze
  s.test_files = ["test/test_unf_ext.rb".freeze]

  s.installed_by_version = "2.6.14" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0.9.2.2"])
      s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
      s.add_development_dependency(%q<rdoc>.freeze, ["> 2.4.2"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.2"])
      s.add_development_dependency(%q<rake-compiler>.freeze, [">= 0.7.9"])
      s.add_development_dependency(%q<rake-compiler-dock>.freeze, ["~> 0.6.0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0.9.2.2"])
      s.add_dependency(%q<test-unit>.freeze, [">= 0"])
      s.add_dependency(%q<rdoc>.freeze, ["> 2.4.2"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.2"])
      s.add_dependency(%q<rake-compiler>.freeze, [">= 0.7.9"])
      s.add_dependency(%q<rake-compiler-dock>.freeze, ["~> 0.6.0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0.9.2.2"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<rdoc>.freeze, ["> 2.4.2"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.2"])
    s.add_dependency(%q<rake-compiler>.freeze, [">= 0.7.9"])
    s.add_dependency(%q<rake-compiler-dock>.freeze, ["~> 0.6.0"])
  end
end
