class AddGithubInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :token, :string
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :location, :string
    add_column :users, :github_image_url, :string
    add_column :users, :github_followers, :integer
    add_column :users, :github_following, :integer
    add_column :users, :github_public_repos, :integer
  end
end
