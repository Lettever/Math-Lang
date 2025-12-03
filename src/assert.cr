macro assert(exp, msg = "Assertion Failed")
    {% if !flag?(:release) %}
        unless {{exp}}
            abort "#{{{msg}}} (#{ {{exp.stringify}} }) at #{__FILE__}:#{__LINE__}"
        end
    {% end %}
end