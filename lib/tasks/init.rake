require 'csv'
namespace :db do
  task :generate_staffs, [:role] => :environment do
    csv_staffs_raw = File.read("#{Rails.root}/db/data/wc2022/staffs.csv")
    # Header: full_name,email
    csv_staffs = CSV.parse(csv_staffs_raw, headers: true)
    csv_staffs.each do |row|
      active = ActiveModel::Type::Boolean.new.cast(row['active'])
      staff = User.find_by_email(row['email'])
      unless staff
        generated_password = Settings.is_demo ? '12345678' : Devise.friendly_token.first(8)
        staff = User.new(
          full_name: row['full_name'],
          username: row['email'].split('@').first.downcase,
          email: row['email'],
          password: generated_password,
          is_active: active
        )
        if staff.save
          staff.add_role :staff
          UserMailer.delay.send_password_to_staff(staff, generated_password) if !Settings.is_turn_off_mail && !Settings.is_demo && active
          
          if active
            # Generate predict champion data for each staff
            predict = staff.predict_champions.new(money: Settings.predict_champion_money.first)
            predict.save
          end
        end
      end
    end
  end

  task :update_special_staff, [:role] => :environment do
    User.find_by(email: "nhihangnguyen98@gmail.com").update_columns(full_name: "Hằng Nguyễn-Châu-Nhị")
  end

  task :generate_new_staff, [:role] => :environment do
    generated_password = Settings.is_demo ? '12345678' : Devise.friendly_token.first(8)
    staff = User.new(
      full_name: 'Nguyễn Châu Nhị Hằng',
      username: 'nhihangnguyen98',
      email: 'nhihangnguyen98@gmail.com',
      password: generated_password
    )

    if staff.save
      staff.add_role :staff
      UserMailer.delay.send_password_to_staff(staff, generated_password) if !Settings.is_turn_off_mail && !Settings.is_demo

      # Generate predict champion data for each staff
      predict = staff.predict_champions.new(money: Settings.predict_champion_money.first)
      predict.save
    end
  end
end
