module ActivitiesHelper
    def favorite?(model)
      if current_user
        current_user.liked? model 
      else
        return false
      end
    end

    def favorite_activity_tag(activity)
      isfavorite = favorite?(activity)
      fa_icon = isfavorite ? "fa fa-heart" : "fa fa-heart-o"
      fa_tag = "<i class=\"#{fa_icon}\"></i> 关注".html_safe
      link_to  fa_tag , favorite_activity_path(activity) , method: :patch , remote: true ,class:'btn btn-primary', favorite: isfavorite
    end

    def delete_activity_tag(activity)
      fa_tag = "<i class=\"fa fa-trash-o\"></i> 删除".html_safe
      link_to  fa_tag , activity, method: :delete , class:'btn btn-danger' 
    end


end
