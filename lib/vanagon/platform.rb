require 'vanagon/platform/dsl'

class Vanagon::Platform
  attr_accessor :make, :servicedir, :defaultdir, :provisioning, :build_dependencies, :name, :vcloud_name, :cflags, :ldflags, :settings, :servicetype, :patch, :architecture, :codename

  def self.load_platform(name, configdir)
    platfile = File.join(configdir, "#{name}.rb")
    code = File.read(platfile)
    dsl = Vanagon::Platform::DSL.new(name)
    dsl.instance_eval(code)
    dsl._platform
  rescue => e
    puts "Error loading platform '#{name}' using '#{platfile}':"
    puts e
    puts e.backtrace.join("\n")
    raise e
  end

  def initialize(name)
    @name = name
  end

  # This allows instance variables to be accessed using the hash lookup syntax
  def [](key)
    if instance_variable_get("@#{key}")
      instance_variable_get("@#{key}")
    end
  end

  def architecture
    @architecture ||= @name.match(/^.*-.*-(.*)$/)[1]
  end

  #
  # Utilities for platform matching
  #

  def is_deb?
    return !!@name.match(/^(debian|ubuntu|cumulus)-.*$/)
  end

  def is_rpm?
    return !!@name.match(/^(el|fedora|eos|nxos|sles)-.*$/)
  end

  def is_el?
    return !!@name.match(/^el-.*$/)
  end

  def is_sles?
    return !!@name.match(/^sles-.*$/)
  end

  def is_fedora?
    return !!@name.match(/^fedora-.*$/)
  end

  def is_aix?
    return !!@name.match(/^aix-.*$/)
  end
end
