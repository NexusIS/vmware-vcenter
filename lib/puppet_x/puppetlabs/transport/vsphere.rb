# Copyright (C) 2013 VMware, Inc.
require 'rbvmomi' if Puppet.features.vsphere? and ! Puppet.run_mode.master?

module PuppetX::Puppetlabs::Transport
  class Vsphere
    attr_accessor :vim
    attr_reader :name

    def initialize(opts)
      @name    = opts[:name]
      options  = opts[:options] || {}
      @options = options.inject({}){|h, (k, v)| h[k.to_sym] = v; h}
      @options[:host]     = opts[:server]
      @options[:user]     = opts[:username]
      @options[:password] = opts[:password]
      Puppet.debug("#{self.class} initializing connection to: #{@options[:host]}")
    end

    def connect
      @vim ||= RbVmomi::VIM.connect(@options)
    end

    def close
      Puppet.debug("#{self.class} closing connection to: #{@options[:host]}")
      @vim.close if @vim
    end
  end
end
