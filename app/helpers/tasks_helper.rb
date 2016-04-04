module TasksHelper
  def state_button(object)
    params = {
        unstarted: {
            name: 'Start',
            next_state: :started,
            css_class: 'btn-default'
        },
        started: {
            name: 'Finish',
            next_state: :finished,
            css_class: 'btn-primary'
        },
        finished: {
            name: 'Deliver',
            next_state: :delivered,
            css_class: 'btn-warning'
        },
        delivered: [
            {
                name: 'Accept',
                next_state: :accepted,
                css_class: 'btn-success'
            },
            {
                name: 'Reject',
                next_state: :rejected,
                css_class: 'btn-danger'
            }
        ],
        accepted: {
            name: 'Start',
            next_state: :started,
            css_class: 'btn-default'
        },
        rejected: {
            name: 'Restart',
            next_state: :started,
            css_class: 'btn-default'
        }
    }
    if params[object.state].is_a?(Array)
      params[object.state].collect do |btn|
        link_to btn[:name],
                state_task_path(object.id, :state => btn[:next_state]),
                method: :patch, class: "btn #{btn[:css_class]} btn-xs"
      end.join("").html_safe
    else
      link_to params[object.state][:name],
              state_task_path(object.id, :state => params[object.state][:next_state]),
              method: :patch, class: "btn #{params[object.state][:css_class]} btn-xs"
    end

  end
end
