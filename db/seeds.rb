# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
usama = Account.new({ email: 'usama.arshad@devsinc.com', full_name: 'Usama Arshad',
                      username: 'usama arshad', is_private: true, password: '123456789',
                      password_confirmation: '123456789' })
usama.save(validate: false)
post1 = Post.new(description: 'First Post', account_id: usama.id)
post1.images.attach(io: File.open(Rails.root.join('app/assets/images/Ruby.jpg')), filename: 'Ruby.jpg')
post1.save

hassan = Account.new({ email: 'hassan.raza@devsinc.com', full_name: 'Hassan Raza',
                       username: 'hassan raza', is_private: true, password: '123456789',
                       password_confirmation: '123456789' })
hassan.save(validate: false)
post2 = Post.new(description: 'First Post', account_id: hassan.id)
post2.images.attach(io: File.open(Rails.root.join('app/assets/images/download.jpeg')), filename: 'download.jpeg')
post2.save

usama.requests_sent.create(recipient_id: hassan.id, status: 'pending')
hassan.requests_sent.create(recipient_id: usama.id, status: 'pending')
