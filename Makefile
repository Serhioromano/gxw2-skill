.PHONY: publish test

# Publish a new version to npm + create a GitHub release.
#   Workflow adapted from Serhioromano/pi-defender/Makefile (changelog automation removed).
#   1. Checks prerequisites (gh, npm login).
#   2. Computes the next version number from package.json + $(v).
#   3. Commits any uncommitted changes.
#   4. Pushes local commits to GitHub.
#   5. Bumps version in package.json and creates a git commit + tag (npm version).
#   6. Pushes the commit and tag to GitHub.
#   7. Publishes the package to npm registry (npm publish).
#   8. Creates a GitHub release with auto-generated notes via gh.
#
# Usage: make publish v=<version>
#   make publish v=patch   — 1.3.0 → 1.3.1
#   make publish v=minor   — 1.3.0 → 1.4.0
#   make publish v=major   — 1.3.0 → 2.0.0
#   make publish v=1.5.0   — explicit version
publish:
	@test -n "$(v)" || { \
		echo "❌ Usage: make publish v=<version>"; echo "   Example: make publish v=patch"; \
		exit 1; \
	}
	@command -v gh >/dev/null 2>&1 || { \
		echo "❌ GitHub CLI (gh) not found. Install: https://cli.github.com/"; \
		exit 1; \
	}
	@gh auth status >/dev/null 2>&1 || { \
		echo "❌ Not logged in to GitHub. Run: gh auth login"; \
		exit 1; \
	}
	@npm whoami >/dev/null 2>&1 || { \
		echo "🔑 Not logged in to npm. Running npm login..."; \
		npm login; \
	}
	@if ! git diff --quiet --exit-code || ! git diff --cached --quiet --exit-code; then \
		echo "📦 Uncommitted changes found. Committing..."; \
		git add -A; \
		git commit -m "Prepare for new version $(v)"; \
	fi
	@git pull --rebase origin main
	@git push origin main
	@newver=$$(npm version $(v) 2>&1 | tail -1); \
		echo "🏷️  Version bumped: $$newver"
	git push origin main --follow-tags
	@echo "🚀 Pushed to GitHub"
	npm publish
	@echo "📦 Published to npm"
	@tag=$$(git describe --tags --abbrev=0); \
		echo "📝 Creating GitHub release: $$tag (auto-generated notes)"; \
		gh release create "$$tag" --title "$$tag" --generate-notes; \
		echo "🎉 GitHub release created: $$tag"
	@echo "🎉 Published! All done."

test:
	@echo "Running skill smoke test..."
	@cd /tmp && rm -rf gxw2-skill-test && mkdir gxw2-skill-test && cd gxw2-skill-test && \
		pi -e $(CURDIR) --no-extensions -p "Which skill is available for GX Works 2 / Mitsubishi ST? Reply with the skill name and its location only."
