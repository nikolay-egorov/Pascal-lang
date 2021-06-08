using System.Text;
using Antlr4.Runtime;
using JetBrains.ReSharper.Feature.Services.Resources;
using JetBrains.ReSharper.Psi;
using JetBrains.ReSharper.Psi.ExtensionsAPI.Tree;
using JetBrains.ReSharper.Psi.Parsing;
using JetBrains.ReSharper.Psi.Tree;
using JetBrains.Text;
using JetBrains.Util;

namespace JetBrains.ReSharper.Plugins.Spring {
    class SpringTokenType : TokenNodeType {
        public static SpringTokenType EQ = new SpringTokenType("EQ", 0);
        public static SpringTokenType NUMBER = new SpringTokenType("NUMBER", 1);
        public static SpringTokenType STRING = new SpringTokenType("STRING", 2);
        public static SpringTokenType BAD_CHARACTER = new SpringTokenType("BAD_CHARACTER", 3);
        public SpringTokenType(string s, int index) : base(s, index)
        {
        }

        public override LeafElementBase Create(IBuffer buffer, TreeOffset startOffset, TreeOffset endOffset) {
            var myRange = new TextRange(startOffset.Offset, endOffset.Offset);
            return new SpringToken(this, buffer.GetText(myRange));
        }

        public override bool IsWhitespace => base.Index == MyLexer.WS;

        public override bool IsComment => base.Index == MyLexer.SINGLE_COMMENT
                                          || base.Index == MyLexer.COMMENT_1 ||
                                          base.Index == MyLexer.COMMENT_2;

        public override bool IsStringLiteral => base.Index == MyLexer.STRING;
        public override bool IsConstantLiteral => base.Index == MyLexer.NUM_INT;
        public override bool IsIdentifier => base.Index == MyLexer.IDENT;
        public override bool IsKeyword { get; }
        public override string TokenRepresentation => ToString();
    }


    public class SpringToken : LeafElementBase, ITokenNode {
        private readonly string myText;

        public SpringToken(NodeType type, string myText) {
            NodeType = type;
            this.myText = myText;
        }

        public override int GetTextLength() {
            return myText.Length;
        }

        public override StringBuilder GetText(StringBuilder to) {
            return to.Append(this.myText);
        }

        public override IBuffer GetTextAsBuffer() {
            return new StringBuffer(myText);
        }

        public override string GetText() {
            return this.myText;
        }

        public override NodeType NodeType { get; }
        public override PsiLanguageType Language => SpringLanguage.Instance;

        public TokenNodeType GetTokenType() {
            return (TokenNodeType) this.NodeType;
        }
        
        public IToken AsToken { get; set; }
    }
}