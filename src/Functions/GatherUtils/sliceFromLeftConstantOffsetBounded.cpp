#ifndef __clang_analyzer__ // It's too hard to analyze.

#include "GatherUtils.h"
#include "Selectors.h"
#include "Algorithms.h"

namespace DB::GatherUtils
{
struct SliceFromLeftConstantOffsetBoundedSelectArraySource
    : public ArraySourceSelector<SliceFromLeftConstantOffsetBoundedSelectArraySource>
{
    template <typename Source>
    static void selectSourceSink(Source && source, size_t & offset, ssize_t & length, ColumnArray::MutablePtr & result)
    {
        using Sink = typename Source::SinkType;
        result = ColumnArray::create(source.createValuesColumn());
        Sink sink(result->getData(), result->getOffsets(), source.getColumnSize());
        sliceFromLeftConstantOffsetBounded(source, sink, offset, length);
    }
};

ColumnArray::MutablePtr sliceFromLeftConstantOffsetBounded(IArraySource & src, size_t offset, ssize_t length)
{
    ColumnArray::MutablePtr res;
    SliceFromLeftConstantOffsetBoundedSelectArraySource::select(src, offset, length, res);
    return res;
}
}

#endif
