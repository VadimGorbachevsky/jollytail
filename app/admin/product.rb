ActiveAdmin.register Product do
      permit_params  :category_id, :accia_id, :name, :price, :action_price, :description, :brand, :real, :flags, :image, :name1, :cart_ids => []


      index do
          selectable_column
          id_column
          column "Категория" do |product|
            product.category.name
          end
          column "Наименование" do |product|
            (product.name != "" && product.name) ?  product.name : "!Ошибка / Наименование не установлено"
          end
          column "Рабочее название" do |product|
            (product.name1 != "" && product.name1) ?  product.name1 : "!Ошибка / Рабочее название не установлено"
          end
          column "Цена" do |product|
            product.price ? product.price : "!Ошибка / Цена не установлена"
          end
          column "Акционный?" do |product|
            product.accia ? product.accia.name : "Нет"
          end
          column "Акционная цена" do |product|
            product.action_price ? product.action_price : "!Предупреждение / Акционная цена не установлена"
          end
          column "Количество" do |product|
            product.productcount ? product.productcount.count : "!Ошибка / Количество не установлено"
          end
          column "Изображение" do |product|
            product.image.attached? ? image_tag(url_for(product.image), size: "50x50") : "Изображение не установлено"
          end
          column "Отображать" do |product|
            product.real
          end
          actions
        end

        form do |f|
          f.inputs do
            f.input :name
            f.input :name1
            f.input :brand
            f.input :description
            f.input :category_id, :as => :select, :collection => Category.all.map { |e| [e.name, e.id]}
            f.input :accia_id, :as => :select, :collection => Accia.all.map { |e| [e.name, e.id]}
            f.input :price
            f.input :action_price
            f.input :flags
            f.input :real
            f.input :image, :as => :file
          end
          f.actions
        end

        after_create do
          resource.slug = Russian.translit(resource.name).parameterize
          resource.save()
        end

end
