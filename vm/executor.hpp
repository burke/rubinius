#ifndef RBX_EXECUTOR_HPP
#define RBX_EXECUTOR_HPP

namespace rubinius {
  class VM;
  class Dispatch;
  class Arguments;
  class CallFrame;
  class Object;

  enum ExecuteStatus {
    cExecuteContinue = 0,
    cExecuteRestart
  };

  typedef Object* (*executor)(VM*, CallFrame*, Dispatch& msg, Arguments& args);
}

#endif
