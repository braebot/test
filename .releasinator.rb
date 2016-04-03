
# List of items to confirm from the person releasing.  Required, but empty list is ok.
configatron.prerelease_checklist_items = [
]

# The directory where all distributed docs are.  Default is '.'
# configatron.base_docs_dir = '.'

def build_method
  command("ls -al")
end

# The command that builds the sdk.  Required.
configatron.build_method = method(:build_method)


def publish_to_package_manager(version)
  sleep 1
  puts "done publishing yay!"
end

# The method that publishes the sdk to the package manager.  Required.
configatron.publish_to_package_manager_method = method(:publish_to_package_manager)

# Whether to publish the root repo to GitHub.  Required.
configatron.release_to_github = true


# Distribution GitHub repo if different from the source repo. Optional.
configatron.downstream_repos = [
  DownstreamRepo.new(
    name="test-downstream",
    url="git@github.paypal.com:jbrateman/test-paypal.git",
    branch="master",
    release_to_github=true,
    files_to_copy=[],    
    post_copy_methods=[],
    build_methods=[]
  ),
  DownstreamRepo.new(
    name="test-downstream2",
    url="git@github.com:braebot/test-downstream.git",
    branch="master",
    # ignored if new_branch_prefix is set
    release_to_github=false,
    files_to_copy=[],
    post_copy_methods=[],
    build_methods=[],
    # if specified, create a new branch with the specified name, rather than tagging
    new_branch_name="test-release-__VERSION__"
  )
]