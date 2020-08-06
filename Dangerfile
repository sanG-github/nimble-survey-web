# frozen_string_literal: true

# Runs rails_best_practices on modified and added files in the PR
rails_best_practices.lint

# Runs Rubocop and submit comments only for changed lines
rubocop.lint(inline_comment: true, force_exclusion: true)

# Runs Brakeman on modified and added files in the PR
brakeman.run

# Runs Reek on modified and added files in the PR
reek.lint

# Runs eslint on modified and added files in the PR
eslint.lint

# Runs slim-lint on modified and added files in the PR
slim_lint.lint

# Suggests code changes in the PR
suggester.suggest
