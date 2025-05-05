const std = @import("std");
const testing = std.testing;

pub const Word = u8;
pub const Scrappage = struct {
    mem: []Word,
};

pub const Symbol = struct {
    kind: Kind,
    ix: Ix,

    pub fn decode(byte: Word) Symbol {
        return .{
            .kind = @enumFromInt(byte >> @bitSizeOf(Ix)),
            .ix = @truncate(byte),
        };
    }

    pub fn encode(sym: Symbol) Word {
        const kind: Word = @intFromEnum(sym.kind);
        const ix: Word = sym.ix;
        return (kind << @bitSizeOf(Ix)) + ix;
    }

    pub const Kind = enum { lambda, index, group };
    pub const Ix = std.meta.Int(.unsigned, @bitSizeOf(Word) - @bitSizeOf(Kind));
};
