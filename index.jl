export coerce

##
# Unsafely convert `value` to be of type `T`
#
coerce(T::DataType, value) = convert(T, value)
coerce(::Type{Int}, n::String) = int(n)
coerce(::Type{FloatingPoint}, n::String) = float(n)

##
# lift `f` so its arguments can be coerced to the correct type
#
function coerce(f::Function)
  ast = ccall(:jl_uncompress_ast, Any, (Any, Any), f.code, f.code.ast)
  params = ast.args[1]
  types = map(params) do param
    if isa(param, Expr) && param.head == symbol("::")
      eval(param.args[2])
    else
      Any
    end
  end

  all(t -> t === Any, types) && return f

  function(args...)
    f(map(coerce, types, args)...)
  end
end
