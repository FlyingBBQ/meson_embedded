cpputest_inc = include_directories('CppUTest/include', is_system : true)

memoryleak = files(
  'CppUTest/include/CppUTest/MemoryLeakDetectorNewMacros.h',
  'CppUTest/include/CppUTest/MemoryLeakDetectorMallocMacros.h'
)

cpputest_src = files(
  'CppUTest/src/CppUTest/CommandLineArguments.cpp',
  'CppUTest/src/CppUTest/MemoryLeakWarningPlugin.cpp',
  'CppUTest/src/CppUTest/TestHarness_c.cpp',
  'CppUTest/src/CppUTest/TestRegistry.cpp',
  'CppUTest/src/CppUTest/CommandLineTestRunner.cpp',
  'CppUTest/src/CppUTest/SimpleString.cpp',
  'CppUTest/src/CppUTest/TestMemoryAllocator.cpp',
  'CppUTest/src/CppUTest/TestResult.cpp',
  'CppUTest/src/CppUTest/JUnitTestOutput.cpp',
  'CppUTest/src/CppUTest/TeamCityTestOutput.cpp',
  'CppUTest/src/CppUTest/TestFailure.cpp',
  'CppUTest/src/CppUTest/TestOutput.cpp',
  'CppUTest/src/CppUTest/MemoryLeakDetector.cpp',
  'CppUTest/src/CppUTest/TestFilter.cpp',
  'CppUTest/src/CppUTest/TestPlugin.cpp',
  'CppUTest/src/CppUTest/TestTestingFixture.cpp',
  'CppUTest/src/CppUTest/SimpleMutex.cpp',
  'CppUTest/src/CppUTest/Utest.cpp'
)

cpputestext_src = files(
  'CppUTest/src/CppUTestExt/CodeMemoryReportFormatter.cpp',
  'CppUTest/src/CppUTestExt/IEEE754ExceptionsPlugin.cpp',
  'CppUTest/src/CppUTestExt/MemoryReporterPlugin.cpp',
  'CppUTest/src/CppUTestExt/MockFailure.cpp',
  'CppUTest/src/CppUTestExt/MockSupportPlugin.cpp',
  'CppUTest/src/CppUTestExt/MockActualCall.cpp',
  'CppUTest/src/CppUTestExt/MockSupport_c.cpp',
  'CppUTest/src/CppUTestExt/MemoryReportAllocator.cpp',
  'CppUTest/src/CppUTestExt/MockExpectedCall.cpp',
  'CppUTest/src/CppUTestExt/MockNamedValue.cpp',
  'CppUTest/src/CppUTestExt/OrderedTest.cpp',
  'CppUTest/src/CppUTestExt/MemoryReportFormatter.cpp',
  'CppUTest/src/CppUTestExt/MockExpectedCallsList.cpp',
  'CppUTest/src/CppUTestExt/MockSupport.cpp'
)

platform_src = files('CppUTest/src/Platforms/Gcc/UtestPlatform.cpp')

# build the libraries
cpputest_lib = static_library('cpputest_lib',
  [cpputest_src, platform_src],
  include_directories : cpputest_inc,
  native : true)

cpputestext_lib = static_library('cpputestext_lib',
  [cpputestext_src, platform_src],
  include_directories : cpputest_inc,
  native : true)

# dependency to use when making test executable
cpputest_dep = declare_dependency(
  link_with : [cpputest_lib, cpputestext_lib],
  include_directories : cpputest_inc)

memleak_arg = []
# parse memleak files
foreach memleak : memoryleak
  memleak_arg += ['-include @0@/@1@'.format(meson.source_root(), memleak)]
endforeach

# add your test sources
test_src = files('sometest.cpp')

test_exe = executable(
  'test_exe',
  [test_src, 'cpputest_main.cpp'],
  link_with : cpputest_lib,
  c_args : '-include ../../test/CppUTest/include/CppUTest/MemoryLeakDetectorMallocMacros.h',
  cpp_args : '-include ../../test/CppUTest/include/CppUTest/MemoryLeakDetectorNewMacros.h',
  #cpp_args : memleak_arg[0],
  override_options : ['b_asneeded=false', 'b_lundef=false'],
  #dependencies : [cpputest_dep, cpputestext_dep]
  include_directories : cpputest_inc,
  native : true)

# make the test executable visible to the build system test framework
test('Unit tests', test_exe)
