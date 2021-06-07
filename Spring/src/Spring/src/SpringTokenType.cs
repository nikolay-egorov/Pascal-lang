using System.Text;
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

        public override bool IsWhitespace { get; }
        public override bool IsComment { get; }
        public override bool IsStringLiteral { get; }
        public override bool IsConstantLiteral { get; }
        public override bool IsIdentifier { get; }
        public override bool IsKeyword { get; }
        public override string TokenRepresentation { get; }
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
    }
}