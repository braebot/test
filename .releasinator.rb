configatron.product_name = "test product"

# List of items to confirm from the person releasing.
configatron.prerelease_checklist_items = [
  "Cross your t's and dot your ... lower case j's?"
]

configatron.use_git_flow = true

# The directory where all distributed docs are.  Default is '.'
# configatron.base_docs_dir = '.'

def build_method
  command("ls -al")
end

# The command that builds the sdk.  Required.
configatron.build_method = method(:build_method)

def publish_to_package_manager(version)
  puts "done publishing yay!"
end

# The method that publishes the sdk to the package manager.  Required.
configatron.publish_to_package_manager_method = method(:publish_to_package_manager)

# Whether to publish the root repo to GitHub.  Required.
configatron.release_to_github = true

# Distribution GitHub repo if different from the source repo. Optional.
configatron.downstream_repos = [
  DownstreamRepo.new(
    "test-paypal",
    "git@github.paypal.com:jbrateman/test-paypal.git",
    "master",

    :release_to_github => true
  ),
  DownstreamRepo.new(
    "test-downstream",
    "git@github.com:braebot/test-downstream.git",
    "master",
    # create a new branch with the specified name, rather than tagging
    :new_branch_name => "test-release-__VERSION__"
  )
]

def build_docs
  command("mkdir docs/")
  command("date > docs/index.html")
end

configatron.doc_build_method = method(:build_docs)
configatron.doc_target_dir = "downstream_repos/test-downstream"
configatron.doc_files_to_copy = [
  CopyFile.new("docs/index.html", ".", ".")
]

