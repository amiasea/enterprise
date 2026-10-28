# resource "azapi_resource" "enterprise_ciam" {
#   type      = "Microsoft.AzureActiveDirectory/ciamDirectories@2023-05-17-preview"
#   name      = "amiasea-enterprise"
#   parent_id = data.azurerm_resource_group.amiasea_imperative.id
#   location  = "United States"

#   body = {
#     properties = {
#       createTenantProperties = {
#         countryCode = "US"
#         displayName = "Amiasea Enterprise"
#       }
#     }

#     sku = {
#       name = "Standard"
#       tier = "A0"
#     }
#   }
# }