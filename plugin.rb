# name: CJKusername-validator
# about:  CJK username support, supported SSO.
# version: 0.1
# authors: lelemka0

after_initialize do
  UserNameSuggester.module_eval do
    def self.remove_unallowed_trailing_characters(name)
      name.gsub!(/[^A-Za-z0-9\u4E00-\u9FD5\u3400-\u4DBF\u{20000}-\u{2A6DF}\u{2A700}-\u{2CEAF}\uF900–\uFAFF\u{2F800}-\u{2FA1D}\uAC00–\uD7AF\u3040-\u30FF\u31F0–\u31FF\u{1B000}–\u{1B0FF}\u3005]+$/, "")
      name
    end
  end
end
