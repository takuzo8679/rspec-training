FactoryBot.define do
  factory :note do
    message { "My important note." }
    association :project # project作成時にuserが作成される
    # association :user # この記載では二重でuserを作成してしまう
    user { project.owner } # 上記のuserを関連付ける

    trait :with_attachment do
      attachment { Rack::Test::UploadedFile.new( \
        "#{Rails.root}/spec/files/attachment.png", 'image/png')}
    end
  end
end
