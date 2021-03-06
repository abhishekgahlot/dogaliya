class GaadsController < ApplicationController

	def index
	end

	def create
		shlok = params[:shlok]
		shlok = sanitize(shlok)
		shlok = hinglish_normalizer(shlok)
		if not (shlok.match(/(chul)|(fudi)|(mal)|(bh?a?n?dh?a?v(a|i))|(ha?ra?mi?( ?)(((z|j)h?a?(d|t)(a|i)?)|((k|c)h?or))?)|(jh?a?na?vh?(a|e)?r)|(sh?uvh?(e|a)?r)|(m(e|a)?dh?(e|a)?r(chod)?)|(bh?(a|e|ai)nchod)|(bah(a|e|ai)nchod)|(bh?aichod)|(b(a|u)?kr(i|e)chod)|((bh?osa?d?chod)|((bh?on?s(a|e)?((di|d)?v(a|e)?l(a|e)?))|(bh?on?s(a|e)?(di|d)?(kae|ke|ka|k)?)|(bhon?s)))|(r(a|u|e)?ndi?(chod)?)|(bhad?a?(v|w)a?(a|e|i))|(bh?osdi?k(e|a|e)?)|(ch(o|u)d(ai|u|a))|(ch(o|u)da?(w|v)a(y|i)e?)|(chusa?n(a|e)(wali))|(chut((iy?ah?(pa?)?)|(a?n)|(iy?(e|a)))?(panti)?)|((gh?(a|e)?l)?chod(iy?ah?))|(gh?an?du?)|(gadha)|(((la(v|u)d(a|e))|(lod(a|e))|(l(a|u)?nd)))|(hij((d|r)(a|e)))|(kuth?r?(a|i)(y?a)?)|(kaa?mchor)|(sa?l(a|i))|(tat(i|e))|(kamin(e|a|i))|(b(o|u)bl(a|e)y)|(jhan?t)|(ba?kchod(iyeh?|i|a|e))/).nil?)
			@response = "Too common. Please try something new :P."
		else
			@gaad_persist = Gaad.where(:shlok => shlok).first
			if @gaad_persist.nil?
				Gaad.create(:shlok => shlok, :frequency => 1)
				@response = "Faad!! you have awesome vocab!"
			else
				@gaad_persist.frequency = 0 if @gaad_persist.frequency.nil? 
				@gaad_persist.frequency += 1
				@gaad_persist.save!
				@response = "Too common. Please try something new :P."
			end
		end
		respond_to do |format|
			format.js
		end
	end

end
