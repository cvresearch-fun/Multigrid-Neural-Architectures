local utils = {}

function utils.MSRinit(model, backend, pow)
   assert(backend == 'nn' or backend == 'cudnn')
   print(string.format('%s.SpatialConvolution with power %3.3f', backend, pow))
   for k,v in pairs(model:findModules(backend..'.SpatialConvolution')) do
      local n = v.kW*v.kH*v.nInputPlane
      v.weight:normal(0, torch.pow(2/n, pow))
      if v.bias then v.bias:zero() end
   end
end

function utils.XAVinit(model, backend, const, sqrt)
   assert(backend == 'nn' or backend == 'cudnn')
   for k,v in pairs(model:findModules(backend..'.SpatialConvolution')) do
      local wIn = v.nInputPlane
      local wOut = v.nOutputPlane
      local val = const * torch.sqrt(sqrt / (wIn + wOut))
      v.weight:uniform(-val, val)
      if v.bias then v.bias:zero() end
   end
end

function utils.GAUSSinit(model, backend, mean, stddev)
   assert(backend == 'nn' or backend == 'cudnn')
   for k,v in pairs(model:findModules(backend..'.SpatialConvolution')) do
      v.weight:normal(mean, stddev)
      if v.bias then v.bias:zero() end
   end
end


function utils.FCinit(model)
   for k,v in pairs(model:findModules'nn.Linear') do
     v.bias:zero()
   end
end

function utils.BNinit(model, backend, w_const, bias_const)
    print(string.format('%s.SpatialBatchNormalization init weight %3.3f, bias %3.3f',
                        backend, w_const, bias_const))
    for k,v in pairs(model:findModules(backend..'.SpatialBatchNormalization')) do
        v.weight:fill(w_const)
        v.bias:fill(bias_const)
    end
end

function utils.DisableBias(model, backend)
   assert(backend == 'nn' or backend == 'cudnn')
   for i,v in ipairs(model:findModules(backend..'.SpatialConvolution')) do
      v.bias = nil
      v.gradBias = nil
   end
end

function utils.testModel(model)
   model:float()
   local imageSize = opt and opt.imageSize or 32
   local input = torch.randn(1,3,imageSize,imageSize):type(model._type)
   print('forward output',{model:forward(input)})
   print('backward output',{model:backward(input,model.output)})
   model:reset()
end

return utils
