#pragma once

#include "IImGuiWindow.h"

#include "sge_engine/GameObject.h"
#include "imgui/imgui.h"
#include <string>

namespace sge {

struct InputState;

struct SGE_ENGINE_API LogWindow : public IImGuiWindow {
	LogWindow(std::string windowName)
	    : m_windowName(std::move(windowName)) {}

	bool isClosed() override { return !m_isOpened; }
	void update(SGEContext* const sgecon, const InputState& is) override;
	const char* getWindowName() const override { return m_windowName.c_str(); }

  private:
	bool m_isOpened = true;
	std::string m_windowName;
	int prevUpdateMessageCount = 0;

};


} // namespace sge
