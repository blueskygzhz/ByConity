#ifndef __clang_analyzer__ // It's too hard to analyze.

#include "GatherUtils.h"
#include "Selectors.h"
#include "Algorithms.h"

namespace DB::GatherUtils
{
struct SliceFromRightConstantOffsetUnboundedSelectArraySource
    : public ArraySourceSelector<SliceFromRightConstantOffsetUnboundedSelectArraySource>
{
    template <typename Source>
    static void selectSourceSink(Source && source, size_t & offset, ColumnArray::MutablePtr & result)
    {
        using Sink = typename Source::SinkType;
        result = ColumnArray::create(source.createValuesColumn());
        Sink sink(result->getData(), result->getOffsets(), source.getColumnSize());
        sliceFromRightConstantOffsetUnbounded(source, sink, offset);
    }
};

ColumnArray::MutablePtr sliceFromRightConstantOffsetUnbounded(IArraySource & src, size_t offset)
{
    ColumnArray::MutablePtr res;
    SliceFromRightConstantOffsetUnboundedSelectArraySource::select(src, offset, res);
    return res;
}
}

#endif
