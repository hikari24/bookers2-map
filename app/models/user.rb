class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image, destroy: false

  include JpPrefecture
  jp_prefecture :prefecture_code

  #prefecture_codeからprefecture_nameに変換するメソッド
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  #地名・住所データを返すメソッド
  def address
    [address_street, address_city, prefecture_code].compact.join(',')
  end

  #addressのカラムに新規登録された場合に 自動で緯度経度の情報を新規登録
  geocoded_by :address, latitude: :latitude, longitude: :longitude

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length:{maximum: 50}
end
