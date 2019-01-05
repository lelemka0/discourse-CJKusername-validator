# name: CJKusername-validator
# about:  CJK username support, supported SSO.
# version: 0.2
# authors: lelemka0

gem "chinese_pinyin", "1.0.1"
gem "romaji", "0.2.4"

after_initialize do
  UserNameSuggester.module_eval do
    def self.sanitize_username(name)
      name = ActiveSupport::Inflector.transliterate(name.to_s)
      # 1. replace characters that aren't allowed with '_'
      name.gsub!(UsernameValidator::CONFUSING_EXTENSIONS, "_")
      # add CJK support
      name.gsub!(/[^\w\u4E00-\u9FD5\u3400-\u4DBF\u{20000}-\u{2A6DF}\u{2A700}-\u{2CEAF}\uF900–\uFAFF\u{2F800}-\u{2FA1D}\uAC00–\uD7AF\u3040-\u30FF\u31F0–\u31FF\u{1B000}–\u{1B0FF}\u3005.-]/, "_")
      # 2. removes unallowed leading characters
      name.gsub!(/^\W+/, "")
      # 3. removes unallowed trailing characters
      name = remove_unallowed_trailing_characters(name)
      # 4. unify special characters
      name.gsub!(/[-_.]{2,}/, "_")
      name
    end
    def self.remove_unallowed_trailing_characters(name)
      # do not remove CJK char
      name.gsub!(/[^A-Za-z0-9\u4E00-\u9FD5\u3400-\u4DBF\u{20000}-\u{2A6DF}\u{2A700}-\u{2CEAF}\uF900–\uFAFF\u{2F800}-\u{2FA1D}\uAC00–\uD7AF\u3040-\u30FF\u31F0–\u31FF\u{1B000}–\u{1B0FF}\u3005]+$/, "")
      name
    end
  end
end
