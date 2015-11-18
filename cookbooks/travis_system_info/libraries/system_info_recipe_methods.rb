module SystemInfoRecipeMethods
  include Chef::Mixin::ShellOut

  def system_info_command(options = {})
    require 'rbconfig'
    "#{RbConfig.ruby} -S system-info -- report #{system_info_options(options)}"
  end

  private

  def system_info_options(options)
    %W(
      --formats human,json
      --human-output #{options.fetch(:dest_dir)}/system_info
      --json-output #{options.fetch(:dest_dir)}/system_info.json
      --commands-file #{options.fetch(:commands_file)}
      --cookbooks-sha #{options.fetch(:cookbooks_sha)}
    ).join(' ')
  end
end

Chef::Recipe.send(:include, SystemInfoRecipeMethods)
