# Copyright (c) 2015, 2017 Oracle and/or its affiliates. All rights reserved. This
# code is released under a tri EPL/GPL/LGPL license. You can use it,
# redistribute it and/or modify it under the terms of the:
#
# Eclipse Public License version 1.0
# GNU General Public License version 2
# GNU Lesser General Public License version 2.1

# TODO CS 3-Feb-17 only load this when people use cexts

class Data

end

module Truffle::CExt

  T_NONE     = 0x00

  T_OBJECT   = 0x01
  T_CLASS    = 0x02
  T_MODULE   = 0x03
  T_FLOAT    = 0x04
  T_STRING   = 0x05
  T_REGEXP   = 0x06
  T_ARRAY    = 0x07
  T_HASH     = 0x08
  T_STRUCT   = 0x09
  T_BIGNUM   = 0x0a
  T_FILE     = 0x0b
  T_DATA     = 0x0c
  T_MATCH    = 0x0d
  T_COMPLEX  = 0x0e
  T_RATIONAL = 0x0f

  T_NIL      = 0x11
  T_TRUE     = 0x12
  T_FALSE    = 0x13
  T_SYMBOL   = 0x14
  T_FIXNUM   = 0x15
  T_UNDEF    = 0x16

  T_IMEMO    = 0x1a
  T_NODE     = 0x1b
  T_ICLASS   = 0x1c
  T_ZOMBIE   = 0x1d

  T_MASK     = 0x1f

  module_function

  def supported?
    Interop.mime_type_supported?('application/x-sulong-library')
  end

  def rb_type(value)
    # TODO CS 23-Jul-16 we could do with making this a kind of specialising case
    # that puts never seen cases behind a transfer

    case value
      when Module
        T_MODULE
      when Class
        T_CLASS
      when Float
        T_FLOAT
      when String
        T_STRING
      when Regexp
        T_REGEXP
      when Array
        T_ARRAY
      when Hash
        T_HASH
      when Struct
        T_STRUCT
      when Bignum
        T_BIGNUM
      when File
        T_FILE
      when Complex
        T_COMPLEX
      when Rational
        T_RATIONAL

      when NilClass
        T_NIL
      when TrueClass
        T_TRUE
      when FalseClass
        T_FALSE
      when Symbol
        T_SYMBOL
      when Fixnum
        T_FIXNUM

      when Object
        T_OBJECT

      else
        raise 'unknown type'
    end
  end

  def RB_TYPE_P(value, type)
    # TODO CS 23-Jul-16 we could do with making this a kind of specialising case
    # that puts never seen cases behind a transfer

    case type
      when T_SYMBOL
        value.is_a?(Symbol)
      when T_STRING
        value.is_a?(String)
      when T_ARRAY
        value.is_a?(Array)
      when T_FILE
        value.is_a?(File)
      else
        raise 'unknown type'
    end
  end

  def rb_check_type(value, type)
    # TODO CS 23-Jul-16 there's more to this method than this...
    if rb_type(value) != type
      raise 'unexpected type'
    end
  end

  def rb_obj_is_instance_of(object, ruby_class)
    object.class == ruby_class
  end

  def SYMBOL_P(value)
    value.is_a?(Symbol)
  end

  def Qundef
    Rubinius::UNDEFINED
  end

  def Qtrue
    true
  end

  def Qfalse
    false
  end

  def Qnil
    nil
  end

  def rb_cArray
    Array
  end

  def rb_cBignum
    Bignum
  end

  def rb_cClass
    Class
  end

  def rb_mComparable
    Comparable
  end

  def rb_cData
    Data
  end

  def rb_mEnumerable
    Enumerable
  end

  def rb_cFalseClass
    FalseClass
  end

  def rb_cFile
    File
  end

  def rb_cFixnum
    Fixnum
  end

  def rb_cFloat
    Float
  end

  def rb_cHash
    Hash
  end

  def rb_cInteger
    Integer
  end

  def rb_cIO
    IO
  end

  def rb_mKernel
    Kernel
  end

  def rb_cMatch
    MatchData
  end

  def rb_cModule
    Module
  end

  def rb_cNilClass
    NilClass
  end

  def rb_cNumeric
    Numeric
  end

  def rb_cObject
    Object
  end

  def rb_cRange
    Range
  end

  def rb_cRegexp
    Regexp
  end

  def rb_cString
    String
  end

  def rb_cStruct
    Struct
  end

  def rb_cSymbol
    Symbol
  end

  def rb_cTime
    Time
  end

  def rb_cThread
    Thread
  end

  def rb_cTrueClass
    TrueClass
  end

  def rb_cProc
    Proc
  end

  def rb_cMethod
    Method
  end

  def rb_cDir
    Dir
  end

  def rb_eArgError
    ArgumentError
  end

  def rb_eEOFError
    EOFError
  end

  def rb_mErrno
    Errno
  end

  def rb_eException
    Exception
  end

  def rb_eFloatDomainError
    FloatDomainError
  end

  def rb_eIndexError
    IndexError
  end

  def rb_eInterrupt
    Interrupt
  end

  def rb_eIOError
    IOError
  end

  def rb_eLoadError
    LoadError
  end

  def rb_eLocalJumpError
    LocalJumpError
  end

  def rb_eMathDomainError
    Math::DomainError
  end

  def rb_eEncCompatError
    Encoding::CompatibilityError
  end

  def rb_eNameError
    NameError
  end

  def rb_eNoMemError
    NoMemoryError
  end

  def rb_eNoMethodError
    NoMethodError
  end

  def rb_eNotImpError
    NotImplementedError
  end

  def rb_eRangeError
    RangeError
  end

  def rb_eRegexpError
    RegexpError
  end

  def rb_eRuntimeError
    RuntimeError
  end

  def rb_eScriptError
    ScriptError
  end

  def rb_eSecurityError
    SecurityError
  end

  def rb_eSignal
    SignalException
  end

  def rb_eStandardError
    StandardError
  end

  def rb_eSyntaxError
    SyntaxError
  end

  def rb_eSystemCallError
    SystemCallError
  end

  def rb_eSystemExit
    SystemExit
  end

  def rb_eSysStackError
    SystemStackError
  end

  def rb_eTypeError
    TypeError
  end

  def rb_eThreadError
    ThreadError
  end

  def rb_mWaitReadable
    IO::WaitReadable
  end

  def rb_mWaitWritable
    IO::WaitWritable
  end

  def rb_eZeroDivError
    ZeroDivisionError
  end

  def rb_stdin
    STDIN
  end

  def rb_stdout
    STDOUT
  end

  def rb_stderr
    STDERR
  end

  def rb_output_fs
    $,
  end

  def rb_rs
    $/
  end

  def rb_output_rs
    $\
  end

  def rb_default_rs
    $;
  end

  def rb_to_int(val)
    Rubinius::Type.rb_to_int(val)
  end

  def rb_fix2int(value)
    if value.nil?
      raise TypeError
    else
      int = value.to_int
      raise RangeError if int >= 2**32
      int
    end
  end

  def rb_fix2uint(value)
    if value.nil?
      raise TypeError
    else
      int = value.to_int
      raise RangeError if int >= 2**32
      int
    end
  end

  def RB_NIL_P(value)
    nil.equal?(value)
  end

  def RB_FIXNUM_P(value)
    value.is_a?(Fixnum)
  end

  def RTEST(value)
    !nil.equal?(value) && !false.equal?(value)
  end

  def rb_require(feature)
    require feature
  end

  def RB_OBJ_TAINTABLE(object)
    case object
      when TrueClass, FalseClass, Fixnum, Float, NilClass, Symbol
        true
      else
        false
    end
  end

  def rb_jt_obj_infect(dest, source)
    Rubinius::Type.infect(dest, source)
  end

  def rb_float_new(value)
    value.to_f
  end

  def rb_num2int(val)
    Rubinius::Type.rb_num2int(val)
  end
  
  def rb_num2long(val)
    Rubinius::Type.rb_num2long(val)
  end

  def rb_Integer(value)
    Integer(value)
  end

  def rb_Float(value)
    Float(value)
  end

  def RFLOAT_VALUE(value)
    value
  end

  def rb_obj_classname(object)
    object.class.name
  end

  def rb_class_of(object)
    object.class
  end

  def rb_obj_respond_to(object, id, priv)
    Rubinius::Type.object_respond_to?(object, id, priv != 0)
  end

  def rb_check_convert_type(obj, type_name, method)
    Rubinius::Type.rb_check_convert_type(obj, Object.const_get(type_name), method.to_sym)
  end
  
  def rb_convert_type(obj, type_name, method)
    Rubinius::Type.rb_convert_type(obj, Object.const_get(type_name), method.to_sym)
  end

  def rb_check_to_integer(obj, method)
    Rubinius::Type.rb_check_to_integer(obj, method.to_sym)
  end

  def rb_obj_method_arity(object, id)
    object.method(id).arity
  end

  def rb_ivar_defined(object, id)
    object.instance_variable_defined?(id)
  end

  def rb_f_global_variables
    Kernel.global_variables
  end

  def rb_obj_instance_variables(object)
    object.instance_variables
  end

  def rb_inspect(object)
    Rubinius::Type.inspect(object)
  end

  def rb_range_new(beg, last, exclude_end)
    Range.new(beg, last, exclude_end != 0)
  end

  def rb_reg_new(java_string, options)
    Regexp.new(String.new(java_string), options)
  end

  def rb_reg_new_str(str, options)
    Regexp.new(str, options)
  end

  def rb_marshal_dump(obj, port)
    Marshal.dump(obj, port)
  end

  def rb_marshal_load(port)
    Marshal.load(port)
  end

  def rb_reg_regcomp(str)
    Regexp.compile(str)
  end

  def rb_reg_match_pre(match)
    match.pre_match
  end

  def rb_reg_nth_match(nth, match)
    return nil if match.nil?
    match[nth]
  end

  def rb_reg_options(re)
    re.options
  end
  
  def rb_to_encoding_index(enc)
    enc = Rubinius::Type.coerce_to_encoding(enc)
    return -1 if enc == false
    rb_enc_find_index(enc.name)
  end

  def rb_locale_encindex
    rb_enc_find_index Encoding.find("locale").name
  end

  def rb_filesystem_encindex
    rb_enc_find_index Encoding.find("filesystem").name
  end

  def rb_ascii8bit_encindex
    rb_enc_find_index Encoding::ASCII_8BIT.name
  end

  def rb_usascii_encindex
    rb_enc_find_index Encoding::US_ASCII.name
  end

  def rb_utf8_encindex
    rb_enc_find_index Encoding::UTF_8.name
  end

  def rb_enc_find_index(name)
    Truffle.invoke_primitive :encoding_enc_find_index, name
  end

  def rb_str_new_frozen(value)
    if value.frozen?
      value
    else
      # There's more to rb_str_new_frozen than this
      String(value).freeze
    end
  end

  def rb_intern(str)
    str.intern
  end

  def rb_str_new(string, length)
    to_ruby_string(string)[0, length].b
  end

  def rb_str_new_nul(length)
    "\0" * length
  end

  def rb_str_new_cstr(java_string)
    String.new(java_string)
  end

  def rb_intern_str(string)
    string.intern
  end

  def rb_string_value_cstr_check(string)
    !string.include?("\0")
  end

  def rb_String(value)
    String(value)
  end

  def RARRAY_PTR(array)
    ArrayPointer.new(array)
  end

  class ArrayPointer

    attr_reader :array

    def initialize(array)
      @array = array
    end

    def size
      array.size
    end

    def [](offset)
      array[index_from_offset(offset)]
    end

    def []=(offset, value)
      array[index_from_offset(offset)] = value
    end

    def index_from_offset(offset)
      offset / 8
    end

  end

  def rb_Array(value)
    Array(value)
  end

  def rb_ary_new
    []
  end

  def rb_ary_new_capa(capacity)
    []
  end

  def rb_hash_new
    {}
  end

  def rb_hash_set_ifnone(hash, value)
    hash.default = value
  end

  def rb_class_real(ruby_class)
    raise 'not implemented'
  end

  def rb_path2class(path)
    Object.const_get(path)
  end

  def rb_proc_new(function, value)
    Proc.new do |*args|
      Truffle::Interop.execute(function, *args)
    end
  end

  def verbose
    $VERBOSE
  end

  def rb_need_block
    if rb_block_given_p == 0
      raise LocalJumpError, "no block given"
    end
  end

  def rb_yield(value)
    block = get_block
    block.call(value)
  end

  def rb_ivar_lookup(object, name, default_value)
    # TODO CS 24-Jul-16 races - needs a new primitive or be defined in Java?
    if object.instance_variable_defined?(name)
      object.instance_variable_get(name)
    else
      default_value
    end
  end

  def rb_exc_raise(exception)
    raise exception
  end

  def rb_raise(object, name)
    raise 'not implemented'
  end

  def rb_ivar_get(object, name)
    Truffle.invoke_primitive :object_ivar_get, object, name.to_sym
  end

  def rb_ivar_set(object, name, value)
    Truffle.invoke_primitive :object_ivar_set, object, name.to_sym, value
  end

  def rb_define_class_under(mod, name, superclass)
    if mod.const_defined?(name, false)
      current_class = mod.const_get(name, false)
      unless current_class.class == Class
        raise TypeError, "#{mod}::#{name} is not a class"
      end
      if superclass != current_class.superclass
        raise TypeError, "superclass mismatch for class #{name}"
      end
      current_class
    else
      mod.const_set name, Class.new(superclass)
    end
  end

  def rb_define_module_under(mod, name)
    if mod.const_defined?(name, false)
      val = mod.const_get(name, false)
      unless val.class == Module
        raise TypeError, "#{mod}::#{name} is not a module"
      end
      val
    else
      mod.const_set name, Module.new
    end
  end

  def rb_define_method(mod, name, function, argc)
    mod.send(:define_method, name) do |*args|
      if argc == -1
        args = [args.size, ::Truffle::CExt::RARRAY_PTR(args), self]
      else
        args = [self, *args]
      end

      # Using raw execute instead of #call here to avoid argument conversion
      Truffle::Interop.execute(function, *args)
    end
  end

  def rb_define_private_method(mod, name, function, argc)
    rb_define_method(mod, name, function, argc)
    mod.send :private, name
  end

  def rb_define_protected_method(mod, name, function, argc)
    rb_define_method(mod, name, function, argc)
    mod.send :protected, name
  end

  def rb_define_module_function(mod, name, function, argc)
    rb_define_method(mod, name, function, argc)
    cext_module_function mod, name.to_sym
  end

  def rb_define_singleton_method(object, name, function, argc)
    rb_define_method(object.singleton_class, name, function, argc)
  end

  def rb_define_alloc_func(ruby_class, function)
    ruby_class.singleton_class.send(:define_method, :allocate) do
      function.call(self)
    end
  end

  def rb_alias(mod, new_name, old_name)
    mod.send(:alias_method, new_name, old_name)
  end

  def rb_undef(mod, name)
    if mod.frozen? or mod.method_defined?(name)
      mod.send(:undef_method, name)
    end
  end

  def rb_attr(ruby_class, name, read, write, ex)
    if ex.zero?
      private = false
      protected = false
      module_function = false
    else
      private = caller_frame_visibility(:private)
      protected = caller_frame_visibility(:protected)
      module_function = caller_frame_visibility(:module_function)
    end

    if read
      ruby_class.send :attr_reader, name
      ruby_class.send :private, name if private
      ruby_class.send :protected, name if protected
      ruby_class.send :module_function, name if module_function
    end

    if write
      ruby_class.send :attr_writer, name
      setter_name = :"#{name}="
      ruby_class.send :private, setter_name if private
      ruby_class.send :protected, setter_name if protected
      ruby_class.send :module_function, setter_name if module_function
    end
  end

  def rb_funcall(object, name, argc, *args)
    object.__send__(name, *args)
  end

  def rb_Rational(num, den)
    Rational.new(num, den)
  end

  def rb_rational_raw(num, den)
    Rational.new(num, den)
  end

  def rb_rational_new(num, den)
    Rational(num, den)
  end

  def rb_Complex(real, imag)
    Complex.new(real, imag)
  end

  def rb_complex_raw(real, imag)
    Complex.new(real, imag)
  end

  def rb_complex_new(real, imag)
    Complex(real, imag)
  end

  def rb_complex_polar(r, theta)
    Complex.new(r, theta)
  end

  def rb_complex_set_real(complex, real)
    Truffle.privately do
      complex.real = real
    end
  end

  def rb_complex_set_imag(complex, imag)
    Truffle.privately do
      complex.imag = imag
    end
  end

  def rb_mutex_new
    Mutex.new
  end

  def rb_mutex_locked_p(mutex)
    mutex.locked?
  end

  def rb_mutex_trylock(mutex)
    mutex.try_lock
  end

  def rb_mutex_lock(mutex)
    mutex.lock
  end

  def rb_mutex_unlock(mutex)
    mutex.unlock
  end

  def rb_mutex_sleep(mutex, timeout)
    mutex.sleep(timeout)
  end

  def rb_mutex_synchronize(mutex, func, arg)
    mutex.synchronize do
      Truffle::Interop.execute(func, arg)
    end
  end

  def rb_gc_enable
    GC.enable
  end

  def rb_gc_disable
    GC.disable
  end

  def rb_nativethread_self
    Thread.current
  end

  def rb_nativethread_lock_initialize
    Mutex.new
  end

  def rb_data_typed_object_wrap(ruby_class, data, data_type)
    object = ruby_class.internal_allocate
    object.instance_variable_set :@data_type, data_type
    object.instance_variable_set :@data, data
    object
  end

  def rb_ruby_verbose_ptr
    $VERBOSE
  end

  def rb_ruby_debug_ptr
    $DEBUG
  end

  def rb_jt_error(message)
    raise RubyTruffleError.new(message)
  end

  def send_splatted(object, method, args)
    object.send(method, *args)
  end

end

Truffle::Interop.export(:ruby_cext, Truffle::CExt)
