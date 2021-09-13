module PostsHelper
  def total_likes_on_post (post)
    post.likes.count
  end

  def total_comments_on_post (post)
    post.comments.count
  end
end
