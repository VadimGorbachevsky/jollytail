ActiveAdmin.register Order do
 permit_params :user_id, :position_ids

 index do
   selectable_column
   id_column
   column "Покупатель" do |order|
     order.user_id ? order.user_id : "Ошибка / Не привязано к пользователю"
   end
   column "Позиции" do |order|
     order.positions ? order.positions.map { |e| e.id } : "Ошибка / Пустой заказ"
   end
   actions
 end
end
