#!/usr/bin/env bash

cat > .git/hooks/pre-commit << EOF
#!/usr/bin/env bash
scripts/lint-text.sh
scripts/lint-code.sh
EOF

chmod +x .git/hooks/pre-commit
