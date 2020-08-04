# frozen_string_literal: true

# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
# declared_trivial = github.pr_title.include? '#trivial'

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
# warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Don't let testing shortcuts get into master by accident
# fail("fdescribe left in tests") if `grep -r fdescribe specs/ `.length > 1
# fail("fit left in tests") if `grep -r fit specs/ `.length > 1

# Warns when there is a big PR
warn('Big PR') if git.lines_of_code > 500

# Runs rails_best_practices on modified and added files in the PR
rails_best_practices.lint

# Runs Rubocop and submit comments only for changed lines
github.dismiss_out_of_range_messages
rubocop.lint inline_comment: true

# Runs eslint on modified and added files in the PR
# eslint.lint

# Runs Reek on modified and added files in the PR
reek.lint

# Runs Brakeman
brakeman.run

# Report test suite code coverage
simplecov.report 'coverage/coverage.json'

# Runs slim-lint on modified and added files in the PR
slim_lint.lint

# Suggests code changes in the PR
suggester.suggest

# Posts a random lgtm picture from lgtm.in
lgtm.check_lgtm
