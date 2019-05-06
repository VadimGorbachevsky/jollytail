ActiveAdmin.register Productcount do
 permit_params :product_id, :count, :ordercount

 index do
   selectable_column
   id_column
   column "Наименование" do |pc|
     (pc.product && pc.product.name && pc.product.name != "")? pc.product.name : "!Ошибка / Наименование не указано"
   end
   column "Количество в наличии" do |pc|
     (pc.product && pc.count) ? pc.count : "!Ошибка / Количество не указано"
   end
   column "Количество оформленных в заказ" do |pc|
     pc.product ? pc.ordercount : "!Ошибка / Количество не указано"
   end
   actions
 end

end
