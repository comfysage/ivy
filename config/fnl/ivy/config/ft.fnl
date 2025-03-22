{:setup (fn []
  (vim.filetype.add {
    :extension {
      :envrc :bash
      :jq :jq
      :rasi :scss
      :tera :tera
      :tmpl :gohtmltmpl
      }
    :filename {
      :.Justfile :just
      :.justfile :just
      :Justfile :just
      :flake.lock :json
      :justfile :just
      }
    :pattern {
      "shaders/.*%.[vf]sh" :glsl
      "templates/.*%.html" :tera
      }}))}

