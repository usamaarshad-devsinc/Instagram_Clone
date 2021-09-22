# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
usama = Account.create(email: 'usama.arshad@devsinc.com', full_name: 'Usama Arshad',
                       username: 'usama arshad', is_private: true, encrypted_password: '123456789')
post1 = usama.posts.build(description: 'First Post')
post1.images.attach(io: File.open("#{Rails.root}/app/assets/images/Ruby.jpg"), filename: 'Ruby.jpg')
post1.save

hassan = Account.create(email: 'hassan.raza@devsinc.com', full_name: 'Hassan Raza',
                        username: 'hassan raza', is_private: true, encrypted_password: '123456789')
post2 = hassan.posts.build(description: 'First Post')
post2.images.attach(io: File.open("#{Rails.root}/app/assets/images/Ruby.jpg"), filename: 'Ruby.jpg')
post2.save

usama.requests_sent.create(recipient_id: hassan.id)
hassan.requests_sent.create(recipient_id: usama.id)
