using System.Collections.Generic;
using Antlr4.Runtime;
using JetBrains.Annotations;
using JetBrains.Reflection;
using JetBrains.ReSharper.Daemon.SyntaxHighlighting;
using JetBrains.ReSharper.Host.Features.SyntaxHighlighting;
using JetBrains.ReSharper.Psi;
using JetBrains.ReSharper.Psi.CSharp.Parsing;
using JetBrains.ReSharper.Psi.ExtensionsAPI.Caches2;
using JetBrains.ReSharper.Psi.Impl;
using JetBrains.ReSharper.Psi.Modules;
using JetBrains.ReSharper.Psi.Parsing;
using JetBrains.ReSharper.Psi.Tree;
using JetBrains.ReSharper.TestFramework;
using JetBrains.Text;
using JetBrains.Util;

namespace JetBrains.ReSharper.Plugins.Spring {
    [Language(typeof(SpringLanguage))]
    class SpringLanguageService : LanguageService {
        public SpringLanguageService([NotNull] PsiLanguageType psiLanguageType,
            [NotNull] IConstantValueService constantValueService) : base(psiLanguageType, constantValueService) {
        }

        public override ILexerFactory GetPrimaryLexerFactory() {
            return new SpringLexerFactory();
        }

        public override ILexer CreateFilteringLexer(ILexer lexer) {
            return lexer;
        }

        public override IParser CreateParser(ILexer lexer, IPsiModule module, IPsiSourceFile sourceFile) {
            return new SpringParser(lexer);
        }

        public override IEnumerable<ITypeDeclaration> FindTypeDeclarations(IFile file) {
            return EmptyList<ITypeDeclaration>.Instance;
        }

        public override ILanguageCacheProvider CacheProvider => null;
        public override bool IsCaseSensitive => true;
        public override bool SupportTypeMemberCache => false;
        public override ITypePresenter TypePresenter => CLRTypePresenter.Instance;

        private class CustomLexer : ILexer {
            private readonly Lexer myLexer;
            private SpringToken tokenPivot;

            public CustomLexer(Lexer myLexer) {
                this.myLexer = myLexer;
                tokenPivot = null;
            }

            public CustomLexer(IBuffer buffer) {
                Buffer = buffer;
                var dataStream = new AntlrInputStream(Buffer.GetText());
                myLexer = new MyLexer(dataStream);
                tokenPivot = null;
            }

            public void Start() {
                Advance();
                // if (tokenPivot == null) {
                //     if (!myLexer.HitEOF) {
                //         Advance();
                //     }
                // }
            }

            public void Advance() {
                if (myLexer.HitEOF) {
                    tokenPivot = null;
                    return;
                }

                var nextToken = myLexer.NextToken();
                CurrentPosition = nextToken.StartIndex;
                var nextTypeAsInt = nextToken.Type;
                var nextTokenType = myLexer.Vocabulary.GetDisplayName(nextTypeAsInt);

                var springTokenType = new SpringTokenType(nextTokenType, nextTypeAsInt);
                tokenPivot = new SpringToken(springTokenType, nextToken.Text) {
                    AsToken = nextToken
                };
            }

            public object CurrentPosition { get; set; }
            public TokenNodeType TokenType => tokenPivot?.GetTokenType();
            public int TokenStart => tokenPivot.AsToken.StartIndex;
            public int TokenEnd => tokenPivot.AsToken.StopIndex + 1;
            public IBuffer Buffer { get; }
        }


        internal class SpringLexerFactory : ILexerFactory {
            public ILexer CreateLexer(IBuffer buffer) {
                // return new CSharpLexer(buffer);
                return new CustomLexer(buffer);
            }
        }
    }
}