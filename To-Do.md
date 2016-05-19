Goal: Build an art blog/tutorial site

Models:

- Users [admin, moderator, user] x
- Posts x
- Comments x
- Categories x
- Post Categories x
- Images x
- Products x
- Reviews x
- Videos x
- Profile x

Associations:

## USERS - ADMIN
- An admin has_many :posts
- An admin has_many :comments
- An admin has_many :commented_posts, through: :comments, :source => :post

- An admin has_many :reviews
- An admin has_many :reviewed_products, through :reviews, source: :product

- An admin has_many :videos (carrierwave)

## USERS - REGULAR
- A user has_many :comments
- A user has_many :commented_posts, through: :comments, :source => :post

- A user has_many :uploaded_images, :source => :image (related to the post)

- A user has_many reviews
- A user has_many :reviewed_products, through :reviews, source: :product

- A user has_one profile

## POSTS
- A post belongs_to a :user (admin only)

- A post has_many :videos (admin only)

- A post has_many :post_categories
- A post has_many :categories, through: :post_categories (post_categories join model)

- A post has_many :comments
- A post has_many :commentors, through: :comments, :source => :user

- A post has_many :images
- A post has_many :image_uploaders, through: :images, :source => :user

## COMMENTS (acts as a join model for posts and users)
- A comment belongs_to :post
- A comment belongs_to :user

## CATEGORIES
- A category has_many :post_categories
- A category has_many :posts, through: :post_categories

## POST_CATEGORIES
- A post_category belongs_to :post
- A post_category belongs_to :category

## IMAGES (carrierwave) (acts as a join model for posts and users)
- An image belongs_to :user
- An image belongs_to :post

## PRODUCTS
- A product has_many :reviews
- A product has_many :reviewers, through: :reviews, :source => :user

## REVIEWS (acts as a join model for products and users)
- A review belongs_to :product
- A review belongs_to :user

## VIDEOS (carrierwave)
- A video belongs_to :post
- A video belongs_to :user

## PROFILE
- A profile belongs_to :user

