$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'approve'
ActiveRecord::Base.class_eval { include Approve }