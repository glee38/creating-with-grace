Goal: Build an art blog/tutorial site

Models:

- Users [admin, moderator, user]
- Posts
- Comments
- Categories
- Images
- Products
- Videos
- Profile
- Reviews (join model)

Associations:

## USERS - ADMIN
- An admin has_many posts
- An admin has_many comments
- An admin has_many commented posts, through comments
- An admin has_many images, through posts
- An admin has_many reviews
- An admin has_many videos

## USERS - REGULAR
- A user has_many comments
- A user has_many commented posts, through comments
- A user has_many uploaded images (related to the post)
- A user has_many reviews
- A user has_one profile or belongs_to a profile

## Posts
- A post belongs_to a user
- A post belongs_to a category
- A post has_many comments
- A post has_many commentors, through comments

