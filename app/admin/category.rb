ActiveAdmin.register Category do
 permit_params :name, :ancestry, :real, :flags, :url

 after_create do
   resource.slug = Russian.translit(resource.name).parameterize
   resource.save()
 end
 
end
