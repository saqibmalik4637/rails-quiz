# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "images", "quizzes")
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "images", "categories")

# Precompile images from quizzes and categories folders
Rails.application.config.assets.precompile += %w( quizzes/*.png categories/*.png )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
