require 'will_paginate/deprecation'

# = You *will* paginate!
#
# First read about WillPaginate::Finder::ClassMethods, then see
# WillPaginate::ViewHelpers. The magical array you're handling in-between is
# WillPaginate::Collection.
#
# Happy paginating!
module WillPaginate
  def self.enable
    Deprecation.warn "WillPaginate::enable() doesn't do anything anymore"
  end

  # Enable named_scope, a feature of Rails 2.1, even if you have older Rails
  # (tested on Rails 2.0.2 and 1.2.6).
  #
  # You can pass +false+ for +patch+ parameter to skip monkeypatching
  # *associations*. Use this if you feel that <tt>named_scope</tt> broke
  # has_many, has_many :through or has_and_belongs_to_many associations in
  # your app. By passing +false+, you can still use <tt>named_scope</tt> in
  # your models, but not through associations.
  def self.enable_named_scope(patch = true)
    return if defined? ActiveRecord::NamedScope
    require 'will_paginate/finders/active_record/named_scope'
    require 'will_paginate/finders/active_record/named_scope_patch' if patch

    ActiveRecord::Base.send :include, WillPaginate::NamedScope
  end
end

if defined?(Rails)
  require 'will_paginate/view_helpers/action_view' if defined?(ActionController)
  require 'will_paginate/finders/active_record'    if defined?(ActiveRecord)
end

if defined?(Merb::Plugins)
  require 'will_paginate/collection'
  require 'will_paginate/view_helpers/base'
  require 'will_paginate/view_helpers/link_renderer'
  # this only includes will_paginate view stuff in Merb (not finder adapters)
  Merb::AbstractController.send(:include, WillPaginate::ViewHelpers::Base)
end
