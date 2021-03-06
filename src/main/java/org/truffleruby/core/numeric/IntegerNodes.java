/*
 * Copyright (c) 2014, 2017 Oracle and/or its affiliates. All rights reserved. This
 * code is released under a tri EPL/GPL/LGPL license. You can use it,
 * redistribute it and/or modify it under the terms of the:
 *
 * Eclipse Public License version 1.0
 * GNU General Public License version 2
 * GNU Lesser General Public License version 2.1
 */
package org.truffleruby.core.numeric;

import com.oracle.truffle.api.CompilerDirectives;
import com.oracle.truffle.api.dsl.Cached;
import com.oracle.truffle.api.dsl.NodeChild;
import com.oracle.truffle.api.dsl.Specialization;
import com.oracle.truffle.api.frame.VirtualFrame;
import com.oracle.truffle.api.nodes.LoopNode;
import com.oracle.truffle.api.object.DynamicObject;
import org.truffleruby.builtins.CoreClass;
import org.truffleruby.builtins.CoreMethod;
import org.truffleruby.builtins.CoreMethodArrayArgumentsNode;
import org.truffleruby.builtins.YieldingCoreMethodNode;
import org.truffleruby.core.numeric.IntegerNodesFactory.IntegerMulNodeGen;
import org.truffleruby.language.RubyNode;
import org.truffleruby.language.dispatch.CallDispatchHeadNode;
import org.truffleruby.language.methods.UnsupportedOperationBehavior;

@CoreClass("Integer")
public abstract class IntegerNodes {

    @CoreMethod(names = "downto", needsBlock = true, required = 1, returnsEnumeratorIfNoBlock = true, unsupportedOperationBehavior = UnsupportedOperationBehavior.ARGUMENT_ERROR)
    public abstract static class DownToNode extends YieldingCoreMethodNode {

        @Child private CallDispatchHeadNode downtoInternalCall;

        @Specialization
        public Object downto(int from, int to, DynamicObject block) {
            int count = 0;

            try {
                for (int i = from; i >= to; i--) {
                    if (CompilerDirectives.inInterpreter()) {
                        count++;
                    }

                    yield(block, i);
                }
            } finally {
                if (CompilerDirectives.inInterpreter()) {
                    LoopNode.reportLoopCount(this, count);
                }
            }

            return nil();
        }

        @Specialization
        public Object downto(int from, double to, DynamicObject block) {
            return downto(from, (int) Math.ceil(to), block);
        }

        @Specialization
        public Object downto(long from, long to, DynamicObject block) {
            // TODO BJF 22-Apr-2015 how to handle reportLoopCount(long)
            int count = 0;

            try {
                for (long i = from; i >= to; i--) {
                    if (CompilerDirectives.inInterpreter()) {
                        count++;
                    }

                    yield(block, i);
                }
            } finally {
                if (CompilerDirectives.inInterpreter()) {
                    LoopNode.reportLoopCount(this, count);
                }
            }

            return nil();
        }

        @Specialization
        public Object downto(long from, double to, DynamicObject block) {
            return downto(from, (long) Math.ceil(to), block);
        }

        @Specialization(guards = "isDynamicObject(from) || isDynamicObject(to)")
        public Object downto(VirtualFrame frame, Object from, Object to, DynamicObject block) {
            if (downtoInternalCall == null) {
                CompilerDirectives.transferToInterpreterAndInvalidate();
                downtoInternalCall = insert(CallDispatchHeadNode.createOnSelf());
            }

            return downtoInternalCall.callWithBlock(frame, from, "downto_internal", block, to);
        }

    }

    @CoreMethod(names = { "to_i", "to_int" })
    public abstract static class ToINode extends CoreMethodArrayArgumentsNode {

        @Specialization
        public int toI(int n) {
            return n;
        }

        @Specialization
        public long toI(long n) {
            return n;
        }

        @Specialization(guards = "isRubyBignum(n)")
        public DynamicObject toI(DynamicObject n) {
            return n;
        }

    }

    @CoreMethod(names = "upto", needsBlock = true, required = 1, returnsEnumeratorIfNoBlock = true, unsupportedOperationBehavior = UnsupportedOperationBehavior.ARGUMENT_ERROR)
    public abstract static class UpToNode extends YieldingCoreMethodNode {

        @Child private CallDispatchHeadNode uptoInternalCall;

        @Specialization
        public Object upto(int from, int to, DynamicObject block) {
            int count = 0;

            try {
                for (int i = from; i <= to; i++) {
                    if (CompilerDirectives.inInterpreter()) {
                        count++;
                    }

                    yield(block, i);
                }
            } finally {
                if (CompilerDirectives.inInterpreter()) {
                    LoopNode.reportLoopCount(this, count);
                }
            }

            return nil();
        }

        @Specialization
        public Object upto(int from, double to, DynamicObject block) {
            return upto(from, (int) Math.floor(to), block);
        }

        @Specialization
        public Object upto(long from, long to, DynamicObject block) {
            int count = 0;

            try {
                for (long i = from; i <= to; i++) {
                    if (CompilerDirectives.inInterpreter()) {
                        count++;
                    }

                    yield(block, i);
                }
            } finally {
                if (CompilerDirectives.inInterpreter()) {
                    LoopNode.reportLoopCount(this, count);
                }
            }

            return nil();
        }

        @Specialization
        public Object upto(long from, double to, DynamicObject block) {
            return upto(from, (long) Math.ceil(to), block);
        }

        @Specialization(guards = "isDynamicObject(from) || isDynamicObject(to)")
        public Object upto(VirtualFrame frame, Object from, Object to, DynamicObject block) {
            if (uptoInternalCall == null) {
                CompilerDirectives.transferToInterpreterAndInvalidate();
                uptoInternalCall = insert(CallDispatchHeadNode.createOnSelf());
            }

            return uptoInternalCall.callWithBlock(frame, from, "upto_internal", block, to);
        }

    }

    @NodeChild
    @NodeChild
    public abstract static class IntegerMulNode extends RubyNode {

        public static IntegerMulNode create() {
            return IntegerMulNodeGen.create(null, null);
        }

        public abstract Object executeMul(Object a, Object b);

        @Specialization
        public Object mul(int a, Object b,
                @Cached("create()") FixnumNodes.MulNode fixnumMulNode) {
            return fixnumMulNode.executeMul(a, b);
        }

        @Specialization
        public Object mul(long a, Object b,
                @Cached("create()") FixnumNodes.MulNode fixnumMulNode) {
            return fixnumMulNode.executeMul(a, b);
        }

        @Specialization(guards = "isRubyBignum(a)")
        public Object mul(DynamicObject a, Object b,
                @Cached("create()") BignumNodes.MulNode bignumMulNode) {
            return bignumMulNode.executeMul(a, b);
        }

    }

}
