task "validate:paths" do
  puts "Hi. I just added stuff to validate:paths!"
end

configatron.product_name = "test product"

# List of items to confirm from the person releasing.
configatron.prerelease_checklist_items = [
  "Cross your t's and dot your ... lower case j's?"
]

configatron.use_git_flow = true

# The directory where all distributed docs are found.  If not specified, the default is `.`.
configatron.base_docs_dir = 'sdk'

def validate_gpg
  @validator.validate_in_path("gpg")
end

def validate_mvn
  @validator.validate_in_path("mvn")
end

# List of methods that are run as a step within `validate:all`.  Optional.
configatron.custom_validation_methods = [
  method(:validate_gpg),
  method(:validate_mvn)
]

def build_method
  CommandProcessor.command("ls -al")
end

# The command that builds the sdk.  Required.
configatron.build_method = method(:build_method)

def publish_to_package_manager(version)
  puts "done publishing yay!"
end
configatron.publish_to_package_manager_method = method(:publish_to_package_manager)


def wait_for_package_manager(version)
  puts "done waiting for package manager yay!"
end
configatron.wait_for_package_manager_method = method(:wait_for_package_manager)

# Whether to publish the root repo to GitHub.  Required.
configatron.release_to_github = true

# Distribution GitHub repo if different from the source repo. Optional.
configatron.downstream_repos = [
  DownstreamRepo.new(
    "test-paypal",
    "git@github.paypal.com:jbrateman/test-paypal.git",
    "master",
    :files_to_copy => [
      CopyFile.new("sdk/CHANGELOG.md", "CHANGELOG.md", ".")
    ],
    :release_to_github => true
  ),
  DownstreamRepo.new(
    "test-downstream",
    "git@github.com:braebot/test-downstream.git",
    "master",
    # create a new branch with the specified name, rather than tagging   
    :files_to_copy => [
      CopyFile.new("sdk/CHANGELOG.md", "CHANGELOG.md", ".")
    ],
    :new_branch_name => "test-release-__VERSION__"
  )
]

def build_docs
  Dir.mkdir("docs") unless File.exists?("docs")
  CommandProcessor.command("date >> docs/index.html")
end

configatron.doc_build_method = method(:build_docs)
configatron.doc_target_dir = "downstream_repos/test-downstream"
configatron.doc_files_to_copy = [
  CopyFile.new("docs/index.html", ".", ".")
]

