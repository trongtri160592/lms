# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
LessonType.create([
                      {id: 1, name: 'Web'},
                      {id: 2, name: 'Video'},
                      {id: 3, name: 'Âm thanh'},
                      {id: 4, name: 'Hình ảnh'},
                      {id: 5, name: 'Scorm'},
                      {id: 6, name: 'Flash'},
                      {id: 7, name: 'Bài kiểm tra'}
                  ])
Role.create([
                {id: 1, role: 'Quản lý người dùng'},
                {id: 2, role: 'Quản lý khoá học'},
                {id: 3, role: 'Quản lý nhóm người dùng'},
                {id: 4, role: 'Quản lý chủ đề'},
                {id: 5, role: 'Quản lý kiểu người dùng'},
                {id: 6, role: 'Quản lý chi nhánh'},
                {id: 7, role: 'Cài đặt'},
                {id: 8, role: 'Báo cáo'},
                {id: 9, role: 'Tiến trình học tập'},
                {id: 10, role: 'Tin nhắn'},
                {id: 11, role: 'Tài khoản'}
            ])